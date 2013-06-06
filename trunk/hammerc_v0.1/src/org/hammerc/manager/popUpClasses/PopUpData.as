/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager.popUpClasses
{
	import flash.display.DisplayObject;
	
	/**
	 * <code>PopUpData</code> 类定义了一个弹出窗体的数据对象.
	 * @author wizardc
	 */
	public class PopUpData
	{
		/**
		 * 记录弹出的窗体对象.
		 */
		protected var _popUp:DisplayObject;
		
		/**
		 * 记录弹出窗体对象的模式.
		 */
		protected var _modal:Boolean;
		
		/**
		 * 创建一个 <code>PopUpData</code> 对象.
		 * @param popUp 弹出的窗体对象.
		 * @param modal 弹出窗体对象的模式.
		 */
		public function PopUpData(popUp:DisplayObject, modal:Boolean)
		{
			_popUp = popUp;
			_modal = modal;
		}
		
		/**
		 * 获取弹出的窗体对象.
		 */
		public function get popUp():DisplayObject
		{
			return _popUp;
		}
		
		/**
		 * 设置或获取弹出窗体对象的模式.
		 */
		public function set modal(value:Boolean):void
		{
			_modal = value;
		}
		public function get modal():Boolean
		{
			return _modal;
		}
	}
}
