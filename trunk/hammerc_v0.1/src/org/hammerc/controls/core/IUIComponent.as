/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls.core
{
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	
	import org.hammerc.containers.core.IUIContainer;
	
	/**
	 * <code>IUIComponent</code> 接口定义了组件的通用方法及属性.
	 * @author wizardc
	 */
	public interface IUIComponent extends IEventDispatcher, IBitmapDrawable
	{
		/**
		 * 设置或获取组件是否可以接受用户交互.
		 */
		function set enabled(value:Boolean):void;
		function get enabled():Boolean;
		
		/**
		 * 设置或获取组件的皮肤绘制类.
		 */
		function set skinClass(value:Class):void;
		function get skinClass():Class;
		
		/**
		 * 设置或获取当鼠标在组件上按下时, 是否能够自动获得焦点.
		 */
		function set focusEnabled(value:Boolean):void;
		function get focusEnabled():Boolean;
		
		/**
		 * 设置当前组件为拥有焦点的对象.
		 */
		function setFocus():void;
		
		/**
		 * 获取组件的父层容器.
		 */
		function get parentContainer():IUIContainer;
	}
}
