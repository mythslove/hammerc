/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager.dragClasses
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.hammerc.Global;
	import org.hammerc.events.DragEvent;
	import org.hammerc.manager.DragManager;
	import org.hammerc.manager.LayerManager;
	import org.hammerc.utils.DisplayUtil;
	
	/**
	 * <code>DragProxy</code> 类实现了拖动时的图像代理及拖拽核心方法.
	 * @author wizardc
	 */
	public class DragProxy extends Sprite
	{
		/**
		 * 记录启动拖动的显示对象.
		 */
		protected var _dragInitiator:DisplayObject;
		
		/**
		 * 记录正在拖动的数据对象.
		 */
		protected var _dragData:DragData;
		
		/**
		 * 记录拖动图像的 x 轴偏移.
		 */
		protected var _offsetX:Number;
		
		/**
		 * 记录拖动图像的 y 轴偏移.
		 */
		protected var _offsetY:Number;
		
		/**
		 * 记录允许放置拖动数据的显示对象.
		 */
		protected var _target:DisplayObject;
		
		/**
		 * 记录最后的鼠标事件.
		 */
		protected var _lastMouseEvent:MouseEvent;
		
		/**
		 * 创建一个 <code>DragProxy</code> 对象.
		 * @param dragInitiator 启动拖动的显示对象.
		 * @param dragData 正在拖动的数据对象.
		 */
		public function DragProxy(dragInitiator:DisplayObject, dragData:DragData)
		{
			_dragInitiator = dragInitiator;
			_dragData = dragData;
			Global.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler, true);
			Global.stage.addEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler, true);
		}
		
		/**
		 * 获取启动拖动的显示对象.
		 */
		public function get dragInitiator():DisplayObject
		{
			return _dragInitiator;
		}
		
		/**
		 * 获取正在拖动的数据对象.
		 */
		public function get dragData():DragData
		{
			return _dragData;
		}
		
		/**
		 * 设置或获取拖动图像的 x 轴偏移.
		 */
		public function set offsetX(value:Number):void
		{
			_offsetX = value;
		}
		public function get offsetX():Number
		{
			return _offsetX;
		}
		
		/**
		 * 设置或获取拖动图像的 y 轴偏移.
		 */
		public function set offsetY(value:Number):void
		{
			_offsetY = value;
		}
		public function get offsetY():Number
		{
			return _offsetY;
		}
		
		/**
		 * 设置或获取允许放置拖动数据的显示对象.
		 */
		public function set target(value:DisplayObject):void
		{
			_target = value;
		}
		public function get target():DisplayObject
		{
			return _target;
		}
		
		/**
		 * 获取最后的鼠标事件.
		 */
		public function get lastMouseEvent():MouseEvent
		{
			return _lastMouseEvent;
		}
		
		/**
		 * 鼠标移动时处理方法.
		 * @param event 对应的鼠标事件.
		 */
		protected function mouseMoveHandler(event:MouseEvent):void
		{
			//移动本对象
			var point:Point = new Point(event.localX, event.localY);
			var stagePoint:Point = (event.target as DisplayObject).localToGlobal(point);
			point = LayerManager.getInstance().dragAndDropLayer.globalToLocal(stagePoint);
			this.x = point.x + _offsetX;
			this.y = point.y + _offsetY;
			//取出位于鼠标指针下方的所有显示对象, 由于本对象被添加到不能与鼠标交互的层中, 所以本对象不会出现在列表中
			var targetList:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			DisplayUtil.getObjectsUnderPoint(Global.root, stagePoint, targetList);
			if (targetList.length == 0)
			{
				return;
			}
			//取出末尾的显示对象, 该显示对象为鼠标下嵌套层数最深的显示对象且没有被任何其他对象遮挡
			var nowTarget:DisplayObject = targetList[targetList.length - 1];
			var foundTarget:Boolean = false;
			//遍历最下方的显示对象到最上方
			var enterList:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			while(nowTarget)
			{
				enterList.push(nowTarget);
				//如果存在目标对象且当前对象为目标对象则拖入事件不再继续冒泡
				if(nowTarget == _target)
				{
					foundTarget = true;
					break;
				}
				nowTarget = nowTarget.parent;
			}
			//设置了目标对象但目标对象未找到则抛出拖出事件并取消目标对象
			if(_target != null && !foundTarget)
			{
				this.dispatchDragEvent(DragEvent.DRAG_EXIT, event, _target);
				_target = null;
			}
			//抛出拖入事件
			for each(var target:DisplayObject in enterList)
			{
				this.dispatchDragEvent(DragEvent.DRAG_ENTER, event, target);
			}
		}
		
		/**
		 * 鼠标弹起时处理方法.
		 * @param event 对应的鼠标事件.
		 */
		protected function mouseUpHandler(event:MouseEvent):void
		{
			Global.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler, true);
			Global.stage.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler, true);
			//如果放置目标存在则抛出放下事件
			if(_target != null)
			{
				this.dispatchDragEvent(DragEvent.DRAG_DROP, event, _target);
			}
			//启动拖动的显示对象抛出拖拽完成事件
			this.dispatchDragEvent(DragEvent.DRAG_COMPLETE, event, _dragInitiator);
			//停止拖动
			DragManager.getInstance().endDrag();
			//清空鼠标事件
			_lastMouseEvent = null;
		}
		
		/**
		 * 派送拖拽事件.
		 * @param type 事件类型.
		 * @param mouseEvent 对应的鼠标事件.
		 * @param eventTarget 发送事件的目标对象.
		 */
		public function dispatchDragEvent(type:String, mouseEvent:MouseEvent, eventTarget:Object):void
		{
			var point:Point = new Point(mouseEvent.localX, mouseEvent.localY);
			point = (mouseEvent.target as DisplayObject).localToGlobal(point);
			point = (eventTarget as DisplayObject).globalToLocal(point);
			var dragEvent:DragEvent = new DragEvent(type, _dragInitiator, _dragData);
			dragEvent.buttonDown = mouseEvent.buttonDown;
			dragEvent.relatedObject = mouseEvent.relatedObject;
			dragEvent.localX = point.x;
			dragEvent.localY = point.y;
			dragEvent.altKey = mouseEvent.altKey;
			dragEvent.ctrlKey = mouseEvent.ctrlKey;
			dragEvent.shiftKey = mouseEvent.shiftKey;
			(eventTarget as DisplayObject).dispatchEvent(dragEvent);
		}
	}
}
