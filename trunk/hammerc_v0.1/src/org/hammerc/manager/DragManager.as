/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import org.hammerc.Global;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.events.DragEvent;
	import org.hammerc.manager.dragClasses.DragData;
	import org.hammerc.manager.dragClasses.DragProxy;
	import org.hammerc.manager.invalidateClasses.IInvalidating;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>DragManager</code> 类管理和提供显示对象的拖动.
	 * @author wizardc
	 */
	public class DragManager
	{
		private static var _instance:DragManager;
		
		/**
		 * 获取本类的唯一实例.
		 * @return 本类的唯一实例.
		 */
		public static function getInstance():DragManager
		{
			if(_instance == null)
			{
				_instance = new DragManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		private var _mouseDown:Boolean = false;
		private var _dragging:Boolean = false;
		private var _dragProxy:DragProxy;
		
		/**
		 * 本类为单例类不能实例化.
		 * @param singletonEnforcer 单例类实现对象.
		 */
		public function DragManager(singletonEnforcer:SingletonEnforcer)
		{
			if(singletonEnforcer == null)
			{
				throw new Error("单例类不能进行实例化！");
			}
			Global.stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDownHandler);
			Global.stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
			Global.stage.addEventListener(Event.DEACTIVATE, deactivateHandler);
		}
		
		private function stageMouseDownHandler(event:MouseEvent):void
		{
			_mouseDown = true;
		}
		
		private function stageMouseUpHandler(event:MouseEvent):void
		{
			_mouseDown = false;
		}
		
		private function deactivateHandler(event:Event):void
		{
			if(_dragProxy != null)
			{
				_dragProxy.dispatchDragEvent(DragEvent.DRAG_COMPLETE, _dragProxy.lastMouseEvent, _dragProxy.dragInitiator);
			}
			this.endDrag();
		}
		
		/**
		 * 获取拖拽代理对象.
		 */
		hammerc_internal function get dragProxy():DragProxy
		{
			return _dragProxy;
		}
		
		/**
		 * 获取当前是否正在进行拖拽操作.
		 */
		public function get isDragging():Boolean
		{
			return _dragging;
		}
		
		/**
		 * 启动拖放操作.
		 * @param dragInitiator 指定启动拖动的显示对象.
		 * @param dragData 设置正在拖动的数据对象.
		 * @param mouseEvent 设置与启动拖动相关的鼠标信息.
		 * @param dragImage 要拖动的图像, 默认使用黑边白底的矩形.
		 * @param offsetX 拖动图像的 x 轴偏移, 如指定偏移量则拖动代理对齐该偏移量, 否则使用鼠标按下的坐标.
		 * @param offsetY 拖动图像的 y 轴偏移, 如指定偏移量则拖动代理对齐该偏移量, 否则使用鼠标按下的坐标.
		 * @param imageAlpha 拖动图像的透明度.
		 */
		public function doDrag(dragInitiator:DisplayObject, dragData:DragData, mouseEvent:MouseEvent, dragImage:DisplayObject = null, offsetX:Number = NaN, offsetY:Number = NaN, imageAlpha:Number = 0.5):void
		{
			//正在拖动时不能再次进行拖动
			if(_dragging)
			{
				return;
			}
			//鼠标左键没有按下时不能进行拖动
			if(!(mouseEvent.type == MouseEvent.MOUSE_DOWN || mouseEvent.type == MouseEvent.CLICK || _mouseDown || mouseEvent.buttonDown))
			{
				return;
			}
			//被拖动对象或代理图像的高宽不正确时不能进行拖动
			var proxyWidth:Number = (dragImage != null) ? dragImage.width : dragInitiator.width;
			var proxyHeight:Number = (dragImage != null) ? dragImage.height : dragInitiator.height;
			if(proxyWidth <= 0 || proxyHeight <= 0)
			{
				return;
			}
			//标记正在拖动
			_dragging = true;
			//创建拖动代理
			_dragProxy = new DragProxy(dragInitiator, dragData);
			LayerManager.getInstance().dragAndDropLayer.addChild(_dragProxy);
			//添加拖动代理图像
			if(dragImage == null)
			{
				dragImage = getDefaultDragImage(proxyWidth, proxyHeight);
			}
			_dragProxy.addChild(dragImage);
			if(dragImage is IInvalidating)
			{
				(dragImage as IInvalidating).validateLayoutNow();
				(dragImage as IInvalidating).validateShowNow();
			}
			//拖动代理对象透明度
			_dragProxy.alpha = imageAlpha;
			//应用拖动对象的旋转及缩放, 去掉偏移信息
			var matrix:Matrix = dragInitiator.transform.matrix;
			matrix.tx = matrix.ty = 0;
			dragImage.transform.matrix = matrix;
			dragImage.cacheAsBitmap = true;
			//将本地坐标转换为全局坐标
			var target:Object = mouseEvent.target;
			if(target == null)
			{
				target = dragInitiator;
			}
			var point:Point = new Point(mouseEvent.localX, mouseEvent.localY);
			point = (target as DisplayObject).localToGlobal(point);
			var mouseX:Number = point.x;
			var mouseY:Number = point.y;
			//将拖动对象的坐标转换为全局坐标
			var proxyOrigin:Point = dragInitiator.localToGlobal(new Point());
			//设置偏移量及拖动代理的坐标
			if (isNaN(offsetX))
			{
				_dragProxy.offsetX = proxyOrigin.x - mouseX;
				_dragProxy.x = proxyOrigin.x;
			}
			else
			{
				_dragProxy.offsetX = offsetX;
				_dragProxy.x = mouseX + _dragProxy.offsetX;
			}
			if (isNaN(offsetY))
			{
				_dragProxy.offsetY = proxyOrigin.y - mouseY;
				_dragProxy.y = proxyOrigin.y;
			}
			else
			{
				_dragProxy.offsetY = offsetY;
				_dragProxy.y = mouseY + _dragProxy.offsetY;
			}
			//播放开始拖拽事件
			_dragProxy.dispatchDragEvent(DragEvent.DRAG_START, mouseEvent, dragInitiator);
		}
		
		private function getDefaultDragImage(width:Number, height:Number):Shape
		{
			var shape:Shape = new Shape();
			shape.graphics.lineStyle(0, 0x999999);
			shape.graphics.beginFill(0xffffff);
			shape.graphics.drawRect(0, 0, width, height);
			shape.graphics.endFill();
			return shape;
		}
		
		/**
		 * 设置拖动的显示对象允许放置到指定的显示对象上.
		 * @param target 可以接收当前拖动对象的显示对象.
		 */
		public function acceptDragDrop(target:DisplayObject):void
		{
			if(_dragProxy != null)
			{
				_dragProxy.target = target;
			}
		}
		
		/**
		 * 结束当前进行的拖动操作.
		 */
		public function endDrag():void
		{
			if(_dragProxy != null)
			{
				LayerManager.getInstance().dragAndDropLayer.removeChild(_dragProxy);
				if(_dragProxy.numChildren > 0)
				{
					_dragProxy.removeChildAt(0);
				}
				_dragProxy = null;
			}
			_dragging = false;
		}
	}
}

class SingletonEnforcer{}
