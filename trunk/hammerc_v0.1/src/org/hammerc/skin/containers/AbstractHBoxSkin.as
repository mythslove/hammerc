/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.containers
{
	import org.hammerc.containers.HBox;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.skin.containers.scrollerClasses.AbstractScrollerSkin;
	
	/**
	 * <code>AbstractHBoxSkin</code> 类为水平排列容器对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractHBoxSkin extends AbstractScrollerSkin
	{
		/**
		 * <code>AbstractHBoxSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractHBoxSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractHBoxSkin);
			super(owner);
		}
		
		/**
		 * 获取该皮肤对象对应的组件.
		 * @return 该皮肤对象对应的组件.
		 */
		protected function getOwner():HBox
		{
			return _owner as HBox;
		}
	}
}
