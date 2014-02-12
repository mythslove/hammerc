/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.controls.scrollClasses
{
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.skin.controls.AbstractSimplestButtonSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	
	/**
	 * 
	 * @author wizardc
	 */
	public class HiScrollBarSliderButtonSkin extends AbstractSimplestButtonSkin
	{
		/**
		 * 创建一个 <code>HiScrollBarSliderButtonSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiScrollBarSliderButtonSkin(owner:IUIComponent)
		{
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
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
			this.getOwner().setSize(10, 10);
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
		override public function onSizeChanged(width:Number, height:Number):void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onEnabledChanged(enabled:Boolean):void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onStateChanged(state:int):void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function drawSkin():void
		{
			_background.graphics.clear();
			_background.graphics.lineStyle(1, HiThemeStyle.BUTTON_BORDER);
			_background.graphics.beginFill(HiThemeStyle.BUTTON_FACE);
			_background.graphics.drawRect(0, 0, this.getOwner().width, this.getOwner().height);
			_background.graphics.endFill();
		}
	}
}
