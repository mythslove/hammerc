/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.controls.scrollClasses
{
	import flash.display.Shape;
	
	import org.hammerc.controls.buttonClasses.ButtonState;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.skin.controls.AbstractSimplestButtonSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	
	/**
	 * 
	 * @author wizardc
	 */
	public class HiScrollBarRightButtonSkin extends AbstractSimplestButtonSkin
	{
		/**
		 * 记录按钮的状态.
		 */
		protected var _state:int = ButtonState.BUTTON_UP;
		
		/**
		 * 记录按钮的小箭头.
		 */
		protected var _arrow:Shape;
		
		/**
		 * 创建一个 <code>HiScrollBarRightButtonSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiScrollBarRightButtonSkin(owner:IUIComponent)
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
			//绘制小箭头
			_arrow = new Shape();
			_arrow.graphics.beginFill(HiThemeStyle.DROP_SHADOW, .5);
			_arrow.graphics.moveTo(3, 2);
			_arrow.graphics.lineTo(0, 4);
			_arrow.graphics.lineTo(0, 0);
			_arrow.graphics.endFill();
			this.getOwner().addChild(_arrow);
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
			this.getOwner().removeChild(_arrow);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onSizeChanged(width:Number, height:Number):void
		{
			_arrow.x = (width - _arrow.width) / 2;
			_arrow.y = (height - _arrow.height) / 2;
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
