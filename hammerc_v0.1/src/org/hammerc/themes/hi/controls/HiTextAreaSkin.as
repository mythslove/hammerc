/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.controls
{
	import org.hammerc.controls.HScrollBar;
	import org.hammerc.controls.VScrollBar;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.skin.controls.AbstractTextAreaSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	
	/**
	 * <code>HiTextAreaSkin</code> 类定义了 Hi 主题多行文本字段皮肤.
	 * @author wizardc
	 */
	public class HiTextAreaSkin extends AbstractTextAreaSkin
	{
		/**
		 * 创建一个 <code>HiTextAreaSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiTextAreaSkin(owner:IUIComponent)
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
			this.getOwner().setSize(150, 150);
			this.getOwner().textColor = HiThemeStyle.INPUT_TEXT;
			var textMargin:Margin = this.getOwner().textMargin;
			textMargin.top = textMargin.bottom = textMargin.left = textMargin.right = 2;
			this.getOwner().textMargin = textMargin;
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
