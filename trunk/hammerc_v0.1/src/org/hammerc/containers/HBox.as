/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.containers
{
	import flash.display.DisplayObject;
	
	import org.hammerc.containers.boxClasses.HBoxAlign;
	import org.hammerc.containers.scrollerClasses.AbstractScroller;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.containers.AbstractHBoxSkin;
	
	/**
	 * <code>HBox</code> 类定义了水平排列内部组件的容器.
	 * @author wizardc
	 */
	public class HBox extends AbstractScroller
	{
		/**
		 * 记录子组件的间隔.
		 */
		protected var _gap:Number = 0;
		
		/**
		 * 记录垂直方向的对其方式.
		 */
		protected var _verticalAlign:String = HBoxAlign.TOP;
		
		/**
		 * 创建一个 <code>HBox</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function HBox(skinClass:Class = null)
		{
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractHBoxSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createDefaultSkin():ISkin
		{
			return SkinManager.getInstance().defaultTheme.getDefaultSkin(this);
		}
		
		/**
		 * 设置或获取子组件的间隔.
		 */
		public function set gap(value:Number):void
		{
			if(_gap != value)
			{
				_gap = value;
				this.invalidateLayout();
			}
		}
		public function get gap():Number
		{
			return _gap;
		}
		
		/**
		 * 设置或获取垂直方向的对其方式.
		 */
		public function set verticalAlign(value:String):void
		{
			if(_verticalAlign != value)
			{
				_verticalAlign = value;
				this.invalidateLayout();
			}
		}
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function collocateElements():void
		{
			//获取所有组件的最大高度
			var maxHeight:Number = 0;
			for each(var element:IUIComponent in _elementsList)
			{
				var displayObject:DisplayObject = element as DisplayObject;
				if(maxHeight < displayObject.height)
				{
					maxHeight = displayObject.height;
				}
			}
			//排列所有的组件
			var nowX:Number = 0;
			for each(element in _elementsList)
			{
				displayObject = element as DisplayObject;
				if(_verticalAlign == HBoxAlign.MIDDLE)
				{
					displayObject.y = (maxHeight - displayObject.height) / 2;
				}
				else if(_verticalAlign == HBoxAlign.BOTTOM)
				{
					displayObject.y = maxHeight - displayObject.height;
				}
				else
				{
					displayObject.y = 0;
				}
				displayObject.x = nowX;
				nowX += displayObject.width + _gap;
			}
		}
	}
}
