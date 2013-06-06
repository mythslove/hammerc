/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.controls
{
	import flash.text.TextFormatAlign;
	
	import org.hammerc.controls.Label;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.controls.buttonClasses.ButtonState;
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.skin.controls.AbstractToggleButtonSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	
	/**
	 * <code>HiToggleButtonSkin</code> 类定义了 Hi 主题可选定的按钮皮肤.
	 * @author wizardc
	 */
	public class HiToggleButtonSkin extends AbstractToggleButtonSkin
	{
		/**
		 * 记录按钮的状态.
		 */
		protected var _state:int = ButtonState.BUTTON_UP;
		
		/**
		 * 创建一个 <code>HiToggleButtonSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiToggleButtonSkin(owner:IUIComponent)
		{
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			_labelSkinClass = HiLabelSkin;
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
			this.getOwner().labelAlign = TextFormatAlign.CENTER;
			this.getOwner().label = "Toggle Button";
			var labelMargin:Margin = this.getOwner().labelMargin;
			labelMargin.top = labelMargin.bottom = 2;
			labelMargin.left = labelMargin.right = 5;
			this.getOwner().labelMargin = labelMargin;
			this.getOwner().adjustSizeWithLabel();
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
		override public function createLabel():Label
		{
			return new Label(_labelSkinClass);
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
		override public function onStateChanged(state:int):void
		{
			if(_state != state)
			{
				_state = state;
				switch(_state)
				{
					case ButtonState.BUTTON_UP:
					case ButtonState.BUTTON_OVER:
					case ButtonState.BUTTON_DISABLED:
						_background.filters = [];
						break;
					default:
						_background.filters = [HiThemeStyle.getShadow(3, true)];
						break;
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onSelectedChanged(selected:Boolean):void
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
