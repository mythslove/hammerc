/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls
{
	import org.hammerc.controls.HScrollBar;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.skin.controls.scrollClasses.AbstractScrollBarSkin;
	
	/**
	 * <code>AbstractHScrollBarSkin</code> 类为水平滚动条对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractHScrollBarSkin extends AbstractScrollBarSkin
	{
		/**
		 * <code>AbstractHScrollBarSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractHScrollBarSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractHScrollBarSkin);
			super(owner);
		}
		
		/**
		 * 获取该皮肤对象对应的组件.
		 * @return 该皮肤对象对应的组件.
		 */
		protected function getOwner():HScrollBar
		{
			return _owner as HScrollBar;
		}
	}
}
