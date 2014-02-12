/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.toolTips
{
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.skin.containers.AbstractCanvasSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	
	/**
	 * <code>HiTextToolTipBGSkin</code> 类定义了 Hi 主题的文本工具提示背景皮肤.
	 * @author wizardc
	 */
	public class HiTextToolTipBGSkin extends AbstractCanvasSkin
	{
		/**
		 * 创建一个 <code>HiTextToolTipBGSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiTextToolTipBGSkin(owner:IUIComponent)
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
			//设置样式
			_background.filters = [HiThemeStyle.getShadow(3)];
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
			_background.graphics.clear();
			_background.graphics.lineStyle(1, HiThemeStyle.PANEL_BORDER);
			_background.graphics.beginFill(HiThemeStyle.PANEL_BACKGROUND);
			_background.graphics.drawRoundRect(0, 0, this.getOwner().width, this.getOwner().height, 8);
			_background.graphics.endFill();
		}
	}
}
