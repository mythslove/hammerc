/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.containers
{
	import org.hammerc.containers.Panel;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.skin.containers.scrollerClasses.AbstractScrollerSkin;
	
	/**
	 * <code>AbstractPanelSkin</code> 类为面板对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractPanelSkin extends AbstractScrollerSkin
	{
		/**
		 * <code>AbstractPanelSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractPanelSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractPanelSkin);
			super(owner);
		}
		
		/**
		 * 获取该皮肤对象对应的组件.
		 * @return 该皮肤对象对应的组件.
		 */
		protected function getOwner():Panel
		{
			return _owner as Panel;
		}
	}
}
