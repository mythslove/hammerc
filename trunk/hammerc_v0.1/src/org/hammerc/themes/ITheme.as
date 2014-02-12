/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes
{
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.skin.ISkin;
	
	/**
	 * <code>ITheme</code> 接口定义了主题对象应有的属性及方法.
	 * @author wizardc
	 */
	public interface ITheme
	{
		/**
		 * 获取指定组件的默认皮肤对象.
		 * @param owner 指定的组件对象.
		 * @return 指定组件的默认皮肤对象.
		 */
		function getDefaultSkin(owner:IUIComponent):ISkin;
	}
}
