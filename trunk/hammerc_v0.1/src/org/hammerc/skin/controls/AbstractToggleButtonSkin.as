/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls
{
	import org.hammerc.controls.ToggleButton;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.skin.controls.buttonClasses.AbstractSelectableButtonSkin;
	
	/**
	 * <code>AbstractToggleButtonSkin</code> 类为可选定的按钮对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractToggleButtonSkin extends AbstractSelectableButtonSkin
	{
		/**
		 * <code>AbstractToggleButtonSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractToggleButtonSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractToggleButtonSkin);
			super(owner);
		}
		
		/**
		 * 获取该皮肤对象对应的组件.
		 * @return 该皮肤对象对应的组件.
		 */
		protected function getOwner():ToggleButton
		{
			return _owner as ToggleButton;
		}
	}
}
