/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.controls
{
	import org.hammerc.controls.SimplestButton;
	import org.hammerc.controls.buttonClasses.AbstractButtonBase;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.skin.controls.AbstractHScrollBarSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	import org.hammerc.themes.hi.controls.scrollClasses.HiScrollBarLeftButtonSkin;
	import org.hammerc.themes.hi.controls.scrollClasses.HiScrollBarRightButtonSkin;
	import org.hammerc.themes.hi.controls.scrollClasses.HiScrollBarSliderButtonSkin;
	
	/**
	 * <code>HiHScrollBarSkin</code> 类定义了 Hi 主题的水平滚动条皮肤.
	 * @author wizardc
	 */
	public class HiHScrollBarSkin extends AbstractHScrollBarSkin
	{
		/**
		 * 创建一个 <code>HiHScrollBarSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiHScrollBarSkin(owner:IUIComponent)
		{
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			_upOrLeftButtonSkinClass = HiScrollBarLeftButtonSkin;
			_bottomOrRightButtonSkinClass = HiScrollBarRightButtonSkin;
			_sliderButtonSkinClass = HiScrollBarSliderButtonSkin;
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
			//设置默认属性
			_background.filters = [HiThemeStyle.getShadow(3, true)];
			this.getOwner().setSize(100, 10);
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
		override public function createUpOrLeftButton():AbstractButtonBase
		{
			return new SimplestButton(_upOrLeftButtonSkinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function createBottomOrRightButton():AbstractButtonBase
		{
			return new SimplestButton(_bottomOrRightButtonSkinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function createSliderButton():AbstractButtonBase
		{
			return new SimplestButton(_sliderButtonSkinClass);
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
			_background.graphics.lineStyle(1, HiThemeStyle.BUTTON_BORDER);
			_background.graphics.beginFill(HiThemeStyle.BACKGROUND);
			_background.graphics.drawRect(0, 0, this.getOwner().width, this.getOwner().height);
			_background.graphics.endFill();
		}
	}
}
