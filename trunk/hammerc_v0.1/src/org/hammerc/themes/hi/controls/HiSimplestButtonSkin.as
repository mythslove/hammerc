/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.controls
{
	import org.hammerc.controls.buttonClasses.ButtonState;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.skin.controls.AbstractSimplestButtonSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	
	/**
	 * <code>HiSimplestButtonSkin</code> 类定义了 Hi 主题的简单按钮皮肤.
	 * @author wizardc
	 */
	public class HiSimplestButtonSkin extends AbstractSimplestButtonSkin
	{
		/**
		 * 记录按钮的状态.
		 */
		protected var _state:int = ButtonState.BUTTON_UP;
		
		/**
		 * 创建一个 <code>HiSimplestButtonSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiSimplestButtonSkin(owner:IUIComponent)
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
			this.getOwner().setSize(30, 30);
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
		override public function onStateChanged(state:int):void
		{
			if(_state != state)
			{
				_state = state;
				if(_state == ButtonState.BUTTON_DOWN)
				{
					_background.filters = [HiThemeStyle.getShadow(3, true)];
				}
				else
				{
					_background.filters = [];
				}
			}
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
