/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls
{
	import org.hammerc.controls.VScrollBar;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.skin.controls.scrollClasses.AbstractScrollBarSkin;
	
	/**
	 * <code>AbstractVScrollBarSkin</code> 类为垂直滚动条对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractVScrollBarSkin extends AbstractScrollBarSkin
	{
		/**
		 * <code>AbstractVScrollBarSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractVScrollBarSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractVScrollBarSkin);
			super(owner);
		}
		
		/**
		 * 获取该皮肤对象对应的组件.
		 * @return 该皮肤对象对应的组件.
		 */
		protected function getOwner():VScrollBar
		{
			return _owner as VScrollBar;
		}
	}
}
