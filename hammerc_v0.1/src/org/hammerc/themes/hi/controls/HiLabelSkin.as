/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.controls
{
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.skin.controls.AbstractLabelSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	
	/**
	 * <code>HiLabelSkin</code> 类定义了 Hi 主题的标签皮肤.
	 * @author wizardc
	 */
	public class HiLabelSkin extends AbstractLabelSkin
	{
		/**
		 * 创建一个 <code>HiLabelSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiLabelSkin(owner:IUIComponent)
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
			this.getOwner().textColor = HiThemeStyle.LABEL_TEXT;
			this.getOwner().text = "Label";
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
			this.getOwner().alpha = enabled ? 1 : .5;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function drawSkin():void
		{
		}
	}
}
