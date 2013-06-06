/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls.buttonClasses
{
	import org.hammerc.controls.Label;
	import org.hammerc.controls.buttonClasses.AbstractLabelButton;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractLabelButtonSkin</code> 类为带有文本描述的按钮对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractLabelButtonSkin extends AbstractButtonBaseSkin
	{
		/**
		 * 记录组件内部的标签对象.
		 */
		protected var _label:Label;
		
		/**
		 * 记录标签使用的皮肤类对象.
		 */
		protected var _labelSkinClass:Class;
		
		/**
		 * <code>AbstractLabelButtonSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractLabelButtonSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractLabelButtonSkin);
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			super.configuration();
			_label = (_owner as AbstractLabelButton).hammerc_internal::labelInstance;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function changeChildrenSkinClass():void
		{
			_label.skinClass = _labelSkinClass;
		}
		
		/**
		 * 创建组件内部使用的标签对象.
		 * @return 组件内部使用的标签对象.
		 */
		public function createLabel():Label
		{
			return null;
		}
	}
}
