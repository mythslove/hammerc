/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls.render
{
	/**
	 * <code>IToolTipRender</code> 接口定义了提示渲染对象应有的属性及方法.
	 * @author wizardc
	 */
	public interface IToolTipRender extends IRender
	{
		/**
		 * 当工具提示对象显示时会调用该方法.
		 */
		function show():void;
		
		/**
		 * 当工具提示对象隐藏时会调用该方法.
		 */
		function hide():void;
		
		/**
		 * 当工具提示对象被存入对象池时会调用该方法, 可以在该方法中还原工具提示对象的属性.
		 */
		function reset():void;
	}
}
