/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls
{
	import org.hammerc.controls.Spacer;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.skin.AbstractSkin;
	
	/**
	 * <code>AbstractSpacerSkin</code> 类为间隔对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractSpacerSkin extends AbstractSkin
	{
		/**
		 * <code>AbstractSpacerSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractSpacerSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractSpacerSkin);
			super(owner);
		}
		
		/**
		 * 获取该皮肤对象对应的组件.
		 * @return 该皮肤对象对应的组件.
		 */
		protected function getOwner():Spacer
		{
			return _owner as Spacer;
		}
	}
}
