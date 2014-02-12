/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.containers
{
	import flash.display.DisplayObject;
	
	import org.hammerc.containers.boxClasses.VBoxAlign;
	import org.hammerc.containers.scrollerClasses.AbstractScroller;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.containers.AbstractVBoxSkin;
	
	/**
	 * <code>VBox</code> 类定义了垂直排列内部组件的容器.
	 * @author wizardc
	 */
	public class VBox extends AbstractScroller
	{
		/**
		 * 记录子组件的间隔.
		 */
		protected var _gap:Number = 0;
		
		/**
		 * 记录水平方向的对其方式.
		 */
		protected var _horizontalAlign:String = VBoxAlign.LEFT;
		
		/**
		 * 创建一个 <code>VBox</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function VBox(skinClass:Class = null)
		{
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractVBoxSkin;
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
		 * 设置或获取水平方向的对其方式.
		 */
		public function set horizontalAlign(value:String):void
		{
			if(_horizontalAlign != value)
			{
				_horizontalAlign = value;
				this.invalidateLayout();
			}
		}
		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function collocateElements():void
		{
			//获取所有组件的最大高度
			var maxWidth:Number = 0;
			for each(var element:IUIComponent in _elementsList)
			{
				var displayObject:DisplayObject = element as DisplayObject;
				if(maxWidth < displayObject.width)
				{
					maxWidth = displayObject.width;
				}
			}
			//排列所有的组件
			var nowY:Number = 0;
			for each(element in _elementsList)
			{
				displayObject = element as DisplayObject;
				if(_horizontalAlign == VBoxAlign.CENTER)
				{
					displayObject.x = (maxWidth - displayObject.width) / 2;
				}
				else if(_horizontalAlign == VBoxAlign.RIGHT)
				{
					displayObject.x = maxWidth - displayObject.width;
				}
				else
				{
					displayObject.x = 0;
				}
				displayObject.y = nowY;
				nowY += displayObject.height + _gap;
			}
		}
	}
}
