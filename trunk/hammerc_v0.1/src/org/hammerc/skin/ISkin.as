/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin
{
	/**
	 * <code>ISkin</code> 接口定义了皮肤对象应有的属性及方法.
	 * @author wizardc
	 */
	public interface ISkin
	{
		/**
		 * 设置组件皮肤时被设置的皮肤会调用该方法.
		 */
		function load():void;
		
		/**
		 * 绘制组件皮肤.
		 */
		function drawSkin():void;
		
		/**
		 * 更换组件皮肤时被卸下的皮肤会调用该方法.
		 */
		function unload():void;
	}
}
