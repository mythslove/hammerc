/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.hammerc.Global;
	import org.hammerc.collections.WeakHashMap;
	import org.hammerc.events.PopUpEvent;
	import org.hammerc.manager.popUpClasses.ModalRect;
	import org.hammerc.manager.popUpClasses.PopUpData;
	
	/**
	 * @eventType org.hammerc.events.PopUpEvent.ADD_POPUP
	 */
	[Event(name="addPopUp", type="org.hammerc.events.PopUpEvent")]
	
	/**
	 * @eventType org.hammerc.events.PopUpEvent.REMOVE_POPUP
	 */
	[Event(name="removePopUp", type="org.hammerc.events.PopUpEvent")]
	
	/**
	 * @eventType org.hammerc.events.PopUpEvent.BRING_TO_FRONT
	 */
	[Event(name="bringToFront", type="org.hammerc.events.PopUpEvent")]
	
	/**
	 * <code>PopUpManager</code> 类管理和提供窗口弹出的功能.
	 * @author wizardc
	 */
	public class PopUpManager extends EventDispatcher
	{
		private static var _instance:PopUpManager;
		
		/**
		 * 获取本类的唯一实例.
		 * @return 本类的唯一实例.
		 */
		public static function getInstance():PopUpManager
		{
			if(_instance == null)
			{
				_instance = new PopUpManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		private var _modalColor:uint = 0x000000;
		private var _modalAlpha:Number = .5;
		private var _popUpList:Vector.<DisplayObject>;
		private var _popUpDataList:Vector.<PopUpData>;
		private var _modalMap:WeakHashMap;
		
		/**
		 * 本类为单例类不能实例化.
		 * @param singletonEnforcer 单例类实现对象.
		 */
		public function PopUpManager(singletonEnforcer:SingletonEnforcer)
		{
			if(singletonEnforcer == null)
			{
				throw new Error("单例类不能进行实例化！");
			}
			_popUpList = new Vector.<DisplayObject>();
			_popUpDataList = new Vector.<PopUpData>();
			_modalMap = new WeakHashMap();
		}
		
		/**
		 * 设置或获取模态遮罩的颜色.
		 */
		public function set modalColor(value:uint):void
		{
			_modalColor = value;
		}
		public function get modalColor():uint
		{
			return _modalColor;
		}
		
		/**
		 * 设置或获取模态遮罩的透明度.
		 */
		public function set modalAlpha(value:Number):void
		{
			_modalAlpha = value;
		}
		public function get modalAlpha():Number
		{
			return _modalAlpha;
		}
		
		/**
		 * 获取当前弹出的所有窗口列表.
		 */
		public function get popUpList():Vector.<DisplayObject>
		{
			return _popUpList.concat();
		}
		
		/**
		 * 更具弹出窗口获取弹出窗体的数据对象.
		 * @param popUp 弹出窗口.
		 * @return 弹出窗体的数据对象.
		 */
		private function findPopUpData(popUp:DisplayObject):PopUpData
		{
			for each(var popUpData:PopUpData in _popUpDataList)
			{
				if(popUpData.popUp == popUp)
				{
					return popUpData;
				}
			}
			return null;
		}
		
		/**
		 * 弹出一个窗口.
		 * @param window 要弹出的窗口.
		 * @param parent 要弹出到的容器对象.
		 * @param center 是否居中窗口.
		 * @param modal 是否启用模态.
		 */
		public function addPopUp(window:DisplayObject, parent:DisplayObjectContainer = null, center:Boolean = true, modal:Boolean = false):void
		{
			if(parent == null)
			{
				parent = LayerManager.getInstance().popUpLayer;
			}
			var popUpData:PopUpData = findPopUpData(window);
			if(popUpData != null)
			{
				popUpData.modal = modal;
				window.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			}
			else
			{
				popUpData = new PopUpData(window, modal);
				_popUpList.push(window);
				_popUpDataList.push(popUpData);
			}
			if(center)
			{
				this.centerPopUp(window);
			}
			parent.addChild(window);
			if(modal)
			{
				updateModal(parent);
			}
			window.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			this.dispatchEvent(new PopUpEvent(PopUpEvent.ADD_POPUP, window, modal));
		}
		
		/**
		 * 显示对象从舞台移除时的方法.
		 * @param event 对应的事件对象.
		 */
		private function removedFromStageHandler(event:Event):void
		{
			for(var i:int = 0, len:int = _popUpDataList.length; i < len; i++)
			{
				var popUpData:PopUpData = _popUpDataList[i];
				if(popUpData.popUp == event.target)
				{
					popUpData.popUp.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
					_popUpDataList.splice(i, 1);
					_popUpList.splice(i, 1);
					updateModal(popUpData.popUp.parent);
					break;
				}
			}
		}
		
		/**
		 * 更新模态遮罩.
		 * @param parent 要更新的容器对象.
		 */
		private function updateModal(parent:DisplayObjectContainer):void
		{
			if(parent == null)
			{
				return;
			}
			var modalRect:ModalRect = _modalMap.get(parent) as ModalRect;
			if(modalRect == null)
			{
				modalRect = new ModalRect(_modalColor, _modalAlpha);
				_modalMap.put(parent, modalRect);
			}
			if(modalRect.parent != parent)
			{
				parent.addChild(modalRect);
			}
			var found:Boolean = false;
			for(var i:int = parent.numChildren - 1; i >= 0; i--)
			{
				var element:DisplayObject = parent.getChildAt(i);
				if(element != null)
				{
					var popUpData:PopUpData = findPopUpData(element);
					if(popUpData != null && popUpData.modal)
					{
						found = true;
						break;
					}
				}
			}
			if(found)
			{
				if(parent.getChildIndex(modalRect) < i)
				{
					i--;
				}
				parent.setChildIndex(modalRect, i);
			}
			modalRect.visible = found;
		}
		
		/**
		 * 居中一个弹出窗口.
		 * @param popUp 弹出的窗口.
		 */
		public function centerPopUp(popUp:DisplayObject):void
		{
			if(findPopUpData(popUp) != null)
			{
				var displayObject:DisplayObject = popUp;
				displayObject.x = Global.stage.stageWidth - displayObject.width >> 1;
				displayObject.y = Global.stage.stageHeight - displayObject.height >> 1;
			}
		}
		
		/**
		 * 将指定窗口的层级调至最前.
		 * @param popUp 弹出的窗口.
		 */
		public function bringToFront(popUp:DisplayObject):void
		{
			var popUpData:PopUpData = findPopUpData(popUp);
			if(popUpData != null && popUp.parent != null)
			{
				var parent:DisplayObjectContainer = popUp.parent;
				parent.setChildIndex(popUp, parent.numChildren - 1);
				updateModal(parent);
				this.dispatchEvent(new PopUpEvent(PopUpEvent.BRING_TO_FRONT, popUp));
			}
		}
		
		/**
		 * 移除已经弹出的窗口.
		 * @param popUp 弹出的窗口.
		 */
		public function removePopUp(popUp:DisplayObject):void
		{
			if(popUp != null && popUp.parent != null && findPopUpData(popUp) != null)
			{
				popUp.parent.removeChild(popUp);
				this.dispatchEvent(new PopUpEvent(PopUpEvent.REMOVE_POPUP, popUp));
			}
		}
	}
}

class SingletonEnforcer{}
