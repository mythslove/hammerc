/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls.buttonClasses
{
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	
	/**
	 * <code>AbstractSelectableButtonSkin</code> 类为可选择的按钮对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractSelectableButtonSkin extends AbstractLabelButtonSkin
	{
		/**
		 * <code>AbstractSelectableButtonSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractSelectableButtonSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractSelectableButtonSkin);
			super(owner);
		}
		
		/**
		 * 当组件的选中状态改变后会调用该方法.
		 * @param selected 新设置的选中状态.
		 */
		public function onSelectedChanged(selected:Boolean):void
		{
		}
	}
}
