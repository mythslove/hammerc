/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager.popUpClasses
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.hammerc.Global;
	import org.hammerc.display.IRepaint;
	import org.hammerc.manager.RepaintManager;
	
	/**
	 * <code>ModalRect</code> 类定义了模态对话框的遮罩对象.
	 * @author wizardc
	 */
	public class ModalRect extends Sprite implements IRepaint
	{
		/**
		 * 记录在下一次重绘方法被调用时是否需要进行重绘.
		 */
		protected var _changed:Boolean = false;
		
		/**
		 * 记录图像的宽度.
		 */
		protected var _width:Number = 0;
		
		/**
		 * 记录图像的高度.
		 */
		protected var _height:Number = 0;
		
		/**
		 * 记录图像的颜色.
		 */
		protected var _color:uint;
		
		/**
		 * 创建一个 <code>ModalRect</code> 对象.
		 * @param color 图像的颜色.
		 * @param alpha 图像的透明度.
		 */
		public function ModalRect(color:uint = 0x000000, alpha:Number = .5):void
		{
			RepaintManager.getInstance().register(this);
			this.color = color;
			this.alpha = alpha;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			Global.stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		/**
		 * 设置或获取图像的宽度.
		 */
		override public function set width(value:Number):void
		{
			if(_width != value)
			{
				_width = value;
				this.callRedraw();
			}
		}
		override public function get width():Number
		{
			return _width;
		}
		
		/**
		 * 设置或获取图像的高度.
		 */
		override public function set height(value:Number):void
		{
			if(_height != value)
			{
				_height = value;
				this.callRedraw();
			}
		}
		override public function get height():Number
		{
			return _height;
		}
		
		/**
		 * 设置或获取图像的颜色.
		 */
		public function set color(value:uint):void
		{
			if(_color != value)
			{
				_color = value;
				this.callRedraw();
			}
		}
		public function get color():uint
		{
			return _color;
		}
		
		private function addedToStageHandler(event:Event):void
		{
			this.width = this.stage.stageWidth;
			this.height = this.stage.stageHeight;
		}
		
		private function resizeHandler(event:Event):void
		{
			if(this.stage != null)
			{
				this.width = this.stage.stageWidth;
				this.height = this.stage.stageHeight;
			}
		}
		
		/**
		 * 侦听下次显示列表的绘制.
		 */
		protected function callRedraw():void
		{
			_changed = true;
			RepaintManager.getInstance().callRepaint(this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function repaint():void
		{
			if(_changed)
			{
				this.redraw();
				_changed = false;
			}
		}
		
		/**
		 * 绘制模态图像.
		 */
		protected function redraw():void
		{
			this.graphics.clear();
			this.graphics.beginFill(_color);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
		}
	}
}
