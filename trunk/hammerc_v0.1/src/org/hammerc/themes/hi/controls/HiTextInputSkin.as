/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.controls
{
	import flash.events.FocusEvent;
	
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.skin.controls.AbstractTextInputSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	
	/**
	 * <code>HiTextInputSkin</code> 类定义了 Hi 主题的输入框皮肤.
	 * @author wizardc
	 */
	public class HiTextInputSkin extends AbstractTextInputSkin
	{
		/**
		 * 记录当前文本框是否获得焦点.
		 */
		protected var _hasFocus:Boolean = false;
		
		/**
		 * 创建一个 <code>HiTextInputSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiTextInputSkin(owner:IUIComponent)
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
			_background.filters = [HiThemeStyle.getShadow(3, true)];
			//设置默认属性
			this.getOwner().setSize(100, 24);
			this.getOwner().textColor = HiThemeStyle.INPUT_TEXT;
			var textMargin:Margin = this.getOwner().textMargin;
			textMargin.top = textMargin.bottom = textMargin.left = textMargin.right = 3;
			this.getOwner().textMargin = textMargin;
			//添加焦点事件
			_textField.addEventListener(FocusEvent.FOCUS_IN, focusEventHandler);
			_textField.addEventListener(FocusEvent.FOCUS_OUT, focusEventHandler);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function removeChildren():void
		{
		}
		
		private function focusEventHandler(event:FocusEvent):void
		{
			switch(event.type)
			{
				case FocusEvent.FOCUS_IN:
					_hasFocus = true;
					break;
				case FocusEvent.FOCUS_OUT:
					_hasFocus = false;
					break;
			}
			this.invalidateShow();
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
			_background.graphics.lineStyle(1, _hasFocus ? HiThemeStyle.INPUT_SELECT_BORDER : HiThemeStyle.PANEL_BORDER);
			_background.graphics.beginFill(HiThemeStyle.TEXT_BACKGROUND);
			_background.graphics.drawRect(0, 0, this.getOwner().width, this.getOwner().height);
			_background.graphics.endFill();
		}
	}
}
