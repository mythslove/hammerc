/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls
{
	import org.hammerc.controls.Label;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.skin.controls.textClasses.AbstractTextSkin;
	
	/**
	 * <code>AbstractLabelSkin</code> 类为标签对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractLabelSkin extends AbstractTextSkin
	{
		/**
		 * <code>AbstractLabelSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractLabelSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractLabelSkin);
			super(owner);
		}
		
		/**
		 * 获取该皮肤对象对应的组件.
		 * @return 该皮肤对象对应的组件.
		 */
		protected function getOwner():Label
		{
			return _owner as Label;
		}
	}
}
