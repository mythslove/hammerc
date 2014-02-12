/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.events
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * <code>PopUpEvent</code> 类为弹出窗体管理器的事件类.
	 * @author wizardc
	 */
	public class PopUpEvent extends Event
	{
		/**
		 * 添加一个弹出框时 <code>PopUpManager</code> 会播放该事件.
		 * <p>此事件具有以下属性:</p>
		 * <table class="innertable">
		 *   <tr><th>Property</th><th>Value</th></tr>
		 *   <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>cancelable</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>currentTarget</code></td><td>当前正在使用某个事件侦听器处理该事件的对象.</td></tr>
		 *   <tr><td><code>target</code></td><td>发送该事件的对象.</td></tr>
		 *   <tr><td><code>popUp</code></td><td>弹出框对象.</td></tr>
		 *   <tr><td><code>modal</code></td><td>弹出窗口是否为模态.</td></tr>
		 * </table>
		 * @eventType addPopUp
		 */
		public static const ADD_POPUP:String = "addPopUp";
		
		/**
		 * 移除一个弹出框时 <code>PopUpManager</code> 会播放该事件.
		 * <p>此事件具有以下属性:</p>
		 * <table class="innertable">
		 *   <tr><th>Property</th><th>Value</th></tr>
		 *   <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>cancelable</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>currentTarget</code></td><td>当前正在使用某个事件侦听器处理该事件的对象.</td></tr>
		 *   <tr><td><code>target</code></td><td>发送该事件的对象.</td></tr>
		 *   <tr><td><code>popUp</code></td><td>弹出框对象.</td></tr>
		 *   <tr><td><code>modal</code></td><td>弹出窗口是否为模态.</td></tr>
		 * </table>
		 * @eventType removePopUp
		 */
		public static const REMOVE_POPUP:String = "removePopUp";
		
		/**
		 * 移动弹出框到最前时 <code>PopUpManager</code> 会播放该事件.
		 * <p>此事件具有以下属性:</p>
		 * <table class="innertable">
		 *   <tr><th>Property</th><th>Value</th></tr>
		 *   <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>cancelable</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>currentTarget</code></td><td>当前正在使用某个事件侦听器处理该事件的对象.</td></tr>
		 *   <tr><td><code>target</code></td><td>发送该事件的对象.</td></tr>
		 *   <tr><td><code>popUp</code></td><td>弹出框对象.</td></tr>
		 *   <tr><td><code>modal</code></td><td>弹出窗口是否为模态.</td></tr>
		 * </table>
		 * @eventType bringToFront
		 */
		public static const BRING_TO_FRONT:String = "bringToFront";
		
		/**
		 * 记录弹出框对象.
		 */
		protected var _popUp:DisplayObject;
		
		/**
		 * 记录弹出窗口是否为模态, 此属性仅在事件类型为 <code>ADD_POPUP</code> 时有效.
		 */
		protected var _modal:Boolean;
		
		/**
		 * 创建一个 <code>PopUpEvent</code> 对象.
		 * @param type 事件的类型.
		 * @param popUp 弹出框对象.
		 * @param modal 弹出窗口是否为模态.
		 */
		public function PopUpEvent(type:String, popUp:DisplayObject, modal:Boolean = false)
		{
			super(type, false, false);
			_popUp = popUp;
			_modal = modal;
		}
		
		/**
		 * 获取弹出框对象.
		 */
		public function get popUp():DisplayObject
		{
			return _popUp;
		}
		
		/**
		 * 获取弹出窗口是否为模态, 此属性仅在事件类型为 <code>ADD_POPUP</code> 时有效.
		 */
		public function get modal():Boolean
		{
			return _modal;
		}
		
		/**
		 * 创建本事件对象的副本, 并设置每个属性的值以匹配原始属性值.
		 * @return 其属性值与原始属性值匹配的新对象.
		 */
		override public function clone():Event
		{
			return new PopUpEvent(this.type, this.popUp, this.modal);
		}
		
		/**
		 * 返回一个描述本对象的字符串.
		 * @return 一个字符串, 其中包含本对象的描述.
		 */
		override public function toString():String
		{
			return formatToString("PopUpEvent", "type", "bubbles", "cancelable", "popUp", "modal");
		}
	}
}
