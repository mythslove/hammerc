/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.containers
{
	import org.hammerc.controls.HScrollBar;
	import org.hammerc.controls.VScrollBar;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.skin.containers.AbstractVBoxSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	import org.hammerc.themes.hi.controls.HiHScrollBarSkin;
	import org.hammerc.themes.hi.controls.HiVScrollBarSkin;
	
	/**
	 * <code>HiVBoxSkin</code> 类定义了 Hi 主题的垂直排列容器皮肤.
	 * @author wizardc
	 */
	public class HiVBoxSkin extends AbstractVBoxSkin
	{
		/**
		 * 创建一个 <code>HiVBoxSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiVBoxSkin(owner:IUIComponent)
		{
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			_horizontalScrollBarSkinClass = HiHScrollBarSkin;
			_verticalScrollBarSkinClass = HiVScrollBarSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function addChildren():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			super.configuration();
			//设置样式
			_background.filters = [HiThemeStyle.getShadow(3, true)];
			//设置默认属性
			this.getOwner().setSize(100, 100);
			var contentMargin:Margin = this.getOwner().contentMargin;
			contentMargin.top = contentMargin.bottom = contentMargin.left = contentMargin.right = 1;
			this.getOwner().contentMargin = contentMargin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function removeChildren():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function createHorizontalScrollBar():HScrollBar
		{
			return new HScrollBar(_horizontalScrollBarSkinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function createVerticalScrollBar():VScrollBar
		{
			return new VScrollBar(_verticalScrollBarSkinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onSizeChanged(width:Number, height:Number):void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onEnabledChanged(enabled:Boolean):void
		{
			this.getOwner().alpha = enabled ? 1 : .5;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function drawSkin():void
		{
			_background.graphics.clear();
			_background.graphics.lineStyle(1, HiThemeStyle.PANEL_BORDER);
			_background.graphics.beginFill(HiThemeStyle.PANEL_BACKGROUND);
			_background.graphics.drawRect(0, 0, this.getOwner().width, this.getOwner().height);
			_background.graphics.endFill();
		}
	}
}
