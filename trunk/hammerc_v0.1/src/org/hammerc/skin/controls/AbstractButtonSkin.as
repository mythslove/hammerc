/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls
{
	import org.hammerc.controls.Button;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.skin.controls.buttonClasses.AbstractLabelButtonSkin;
	
	/**
	 * <code>AbstractButtonSkin</code> 类为按钮对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractButtonSkin extends AbstractLabelButtonSkin
	{
		/**
		 * <code>AbstractButtonSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractButtonSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractButtonSkin);
			super(owner);
		}
		
		/**
		 * 获取该皮肤对象对应的组件.
		 * @return 该皮肤对象对应的组件.
		 */
		protected function getOwner():Button
		{
			return _owner as Button;
		}
	}
}
