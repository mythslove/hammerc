/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls.render
{
	import org.hammerc.controls.core.IUIComponent;
	
	/**
	 * <code>IRender</code> 接口定义了渲染对象应有的属性及方法.
	 * @author wizardc
	 */
	public interface IRender extends IUIComponent
	{
		/**
		 * 设置或获取需要进行渲染的数据.
		 */
		function set data(value:Object):void;
		function get data():Object;
	}
}
