/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls.textClasses
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.controls.textClasses.AbstractText;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.AbstractSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractTextSkin</code> 类为显示文本对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractTextSkin extends AbstractSkin
	{
		/**
		 * 记录组件内部显示文本的文本区域对象.
		 */
		protected var _textField:TextField;
		
		/**
		 * 记录组件的文本格式对象.
		 */
		protected var _textFormat:TextFormat;
		
		/**
		 * <code>AbstractTextSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractTextSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractTextSkin);
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			_textField = (_owner as AbstractText).hammerc_internal::textField;
			_textFormat = (_owner as AbstractText).hammerc_internal::textFormat;
		}
	}
}
