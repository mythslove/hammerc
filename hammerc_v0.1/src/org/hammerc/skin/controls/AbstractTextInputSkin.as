/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls
{
	import flash.display.Sprite;
	
	import org.hammerc.controls.TextInput;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.controls.textClasses.AbstractTextSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractTextInputSkin</code> 类为单行文本输入框对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractTextInputSkin extends AbstractTextSkin
	{
		/**
		 * 记录背景显示对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * <code>AbstractTextInputSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractTextInputSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractTextInputSkin);
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			super.configuration();
			_background = this.getOwner().hammerc_internal::background;
		}
		
		/**
		 * 获取该皮肤对象对应的组件.
		 * @return 该皮肤对象对应的组件.
		 */
		protected function getOwner():TextInput
		{
			return _owner as TextInput;
		}
	}
}
