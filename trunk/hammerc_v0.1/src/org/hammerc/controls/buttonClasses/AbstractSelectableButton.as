/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls.buttonClasses
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.skin.controls.buttonClasses.AbstractSelectableButtonSkin;
	
	/**
	 * @eventType flash.events.Event.SELECT
	 */
	[Event(name="select", type="flash.events.Event")]
	
	/**
	 * <code>AbstractSelectableButton</code> 类抽象出可选择的按钮组件应有的属性及方法.
	 * @author wizardc
	 */
	public class AbstractSelectableButton extends AbstractLabelButton
	{
		/**
		 * 记录按钮是否被选中.
		 */
		protected var _selected:Boolean = false;
		
		/**
		 * <code>AbstractSelectableButton</code> 类为抽象类, 不能被实例化.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function AbstractSelectableButton(skinClass:Class = null)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractSelectableButton);
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractSelectableButtonSkin;
		}
		
		/**
		 * 设置或获取按钮是否被选中.
		 */
		public function set selected(value:Boolean):void
		{
			if(_selected != value)
			{
				_selected = value;
				(_skin as AbstractSelectableButtonSkin).onSelectedChanged(_selected);
				this.changeState(_selected ? ButtonState.BUTTON_SELECTED_UP : ButtonState.BUTTON_UP);
				this.dispatchEvent(new Event(Event.SELECT));
			}
		}
		public function get selected():Boolean
		{
			return _selected;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function mouseEventsHandler(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.ROLL_OVER:
					if(!_mouseDown)
					{
						this.changeState(_selected ? ButtonState.BUTTON_SELECTED_OVER : ButtonState.BUTTON_OVER);
					}
					break;
				case MouseEvent.ROLL_OUT:
					if(!_mouseDown)
					{
						this.changeState(_selected ? ButtonState.BUTTON_SELECTED_UP : ButtonState.BUTTON_UP);
					}
					break;
				case MouseEvent.MOUSE_DOWN:
					_mouseDown = true;
					this.changeState(_selected ? ButtonState.BUTTON_SELECTED_DOWN : ButtonState.BUTTON_DOWN);
					break;
				case MouseEvent.MOUSE_UP:
					if(_mouseDown && event.target != this)
					{
						_mouseDown = false;
						this.changeState(_selected ? ButtonState.BUTTON_SELECTED_UP : ButtonState.BUTTON_UP);
					}
					break;
				case MouseEvent.CLICK:
					_mouseDown = false;
					this.buttonClick();
					break;
			}
		}
		
		/**
		 * 按钮被点击后会调用该方法.
		 */
		protected function buttonClick():void
		{
			this.selected = !this.selected;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onEnabledChanged(enabled:Boolean):void
		{
			if(enabled)
			{
				this.changeState(_selected ? ButtonState.BUTTON_SELECTED_UP : ButtonState.BUTTON_UP);
			}
			else
			{
				this.changeState(_selected ? ButtonState.BUTTON_SELECTED_DISABLED : ButtonState.BUTTON_DISABLED);
			}
		}
	}
}
