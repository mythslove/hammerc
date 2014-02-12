/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager
{
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.hammerc_internal;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>FocusManager</code> 类管理程序中的焦点.
	 * @author wizardc
	 */
	public class FocusManager
	{
		private static var _instance:FocusManager;
		
		/**
		 * 获取本类的唯一实例.
		 * @return 本类的唯一实例.
		 */
		public static function getInstance():FocusManager
		{
			if(_instance == null)
			{
				_instance = new FocusManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		/**
		 * 记录当前拥有焦点的对象.
		 */
		private var _currentFocus:IUIComponent;
		
		/**
		 * 本类为单例类不能实例化.
		 * @param singletonEnforcer 单例类实现对象.
		 */
		public function FocusManager(singletonEnforcer:SingletonEnforcer)
		{
			if(singletonEnforcer == null)
			{
				throw new Error("单例类不能进行实例化！");
			}
		}
		
		/**
		 * 获取当前拥有焦点的对象.
		 */
		public function get currentFocus():IUIComponent
		{
			return _currentFocus;
		}
		
		/**
		 * 初始化焦点管理对象.
		 * @param stage 程序的舞台对象.
		 */
		hammerc_internal function initialize(stage:Stage):void
		{
			stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, moiuseFocusChangeHandler);
			stage.addEventListener(FocusEvent.FOCUS_IN, focusInHandler, true);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			stage.addEventListener(Event.ACTIVATE, activateHandler);
		}
		
		/**
		 * 屏蔽原生鼠标点击时的焦点管理.
		 * @param event 对应的事件.
		 */
		private function moiuseFocusChangeHandler(event:FocusEvent):void
		{
			//如果已经取消默认的事件行为则跳过屏蔽
			if(event.isDefaultPrevented())
			{
				return;
			}
			//如果得到焦点的对象为可输入或可选择的文件区域对象则跳过屏蔽
			if(event.relatedObject is TextField)
			{
				var textField:TextField = event.relatedObject as TextField;
				if(textField.type == TextFieldType.INPUT || textField.selectable)
				{
					return;
				}
			}
			//屏蔽焦点的转换
			event.preventDefault();
		}
		
		private function focusInHandler(event:FocusEvent):void
		{
			_currentFocus = getTopLevelFocusTarget(event.target as InteractiveObject);
		}
		
		/**
		 * 获取指定交互对象及其父层可以接收焦点的组件.
		 * @param target 指定的交互对象.
		 * @return 可以接收焦点的组件.
		 */
		private function getTopLevelFocusTarget(target:InteractiveObject):IUIComponent
		{
			while(target != null)
			{
				if(target is IUIComponent && (target as IUIComponent).focusEnabled && (target as IUIComponent).enabled)
				{
					return target as IUIComponent;
				}
				target = target.parent;
			}
			return null;
		}
		
		private function mouseDownHandler(event:MouseEvent):void
		{
			var focus:IUIComponent = getTopLevelFocusTarget(event.target as InteractiveObject);
			if(focus == null)
			{
				return;
			}
			if(focus != _currentFocus && !(focus is TextField))
			{
				focus.setFocus();
			}
		}
		
		private function activateHandler(event:Event):void
		{
			if(_currentFocus != null)
			{
				_currentFocus.setFocus();
			}
		}
	}
}

class SingletonEnforcer{}
