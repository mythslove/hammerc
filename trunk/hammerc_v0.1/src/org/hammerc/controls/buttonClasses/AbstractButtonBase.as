/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls.buttonClasses
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.hammerc.controls.core.AbstractUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.controls.buttonClasses.AbstractButtonBaseSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractButtonBase</code> 类抽象出按钮组件应有的属性及方法.
	 * @author wizardc
	 */
	public class AbstractButtonBase extends AbstractUIComponent
	{
		/**
		 * 记录当前按钮的状态.
		 */
		protected var _state:int = ButtonState.BUTTON_UP;
		
		/**
		 * 记录鼠标是否在该按钮对象上按下.
		 */
		protected var _mouseDown:Boolean = false;
		
		/**
		 * 记录组件内部用于显示按钮实体的背景容器对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * <code>AbstractButtonBase</code> 类为抽象类, 不能被实例化.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function AbstractButtonBase(skinClass:Class = null)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractButtonBase);
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			//添加事件侦听
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			//设置默认属性
			this.mouseChildren = false;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			_background = new Sprite();
			_background.mouseEnabled = _background.mouseChildren = false;
			this.addChild(_background);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractButtonBaseSkin;
		}
		
		/**
		 * 获取组件内部用于显示按钮实体的背景容器对象.
		 */
		hammerc_internal function get background():Sprite
		{
			return _background;
		}
		
		private function addedToStageHandler(event:Event):void
		{
			this.addEventListener(MouseEvent.ROLL_OVER, this.mouseEventsHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, this.mouseEventsHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseEventsHandler);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, this.mouseEventsHandler);
			this.addEventListener(MouseEvent.CLICK, this.mouseEventsHandler);
		}
		
		private function removedFromStageHandler(event:Event):void
		{
			this.removeEventListener(MouseEvent.ROLL_OVER, this.mouseEventsHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT, this.mouseEventsHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseEventsHandler);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.mouseEventsHandler);
			this.removeEventListener(MouseEvent.CLICK, this.mouseEventsHandler);
		}
		
		/**
		 * 鼠标事件处理方法.
		 * @param event 按钮接收的鼠标事件.
		 */
		protected function mouseEventsHandler(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.ROLL_OVER:
					if(!_mouseDown)
					{
						this.changeState(ButtonState.BUTTON_OVER);
					}
					break;
				case MouseEvent.ROLL_OUT:
					if(!_mouseDown)
					{
						this.changeState(ButtonState.BUTTON_UP);
					}
					break;
				case MouseEvent.MOUSE_DOWN:
					_mouseDown = true;
					this.changeState(ButtonState.BUTTON_DOWN);
					break;
				case MouseEvent.MOUSE_UP:
					if(_mouseDown && event.target != this)
					{
						_mouseDown = false;
						this.changeState(ButtonState.BUTTON_UP);
					}
					break;
				case MouseEvent.CLICK:
					_mouseDown = false;
					this.changeState(ButtonState.BUTTON_OVER);
					break;
			}
		}
		
		/**
		 * 改变组件当前的状态.
		 * @param state 要改变为的状态.
		 */
		protected function changeState(state:int):void
		{
			if(_state != state)
			{
				_state = state;
				(_skin as AbstractButtonBaseSkin).onStateChanged(_state);
				this.invalidateShow();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onEnabledChanged(enabled:Boolean):void
		{
			this.changeState(enabled ? ButtonState.BUTTON_UP : ButtonState.BUTTON_DISABLED);
		}
	}
}
