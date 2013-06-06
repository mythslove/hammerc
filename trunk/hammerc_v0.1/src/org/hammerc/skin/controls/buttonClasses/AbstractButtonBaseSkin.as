/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls.buttonClasses
{
	import flash.display.Sprite;
	
	import org.hammerc.controls.buttonClasses.AbstractButtonBase;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.AbstractSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractButtonBaseSkin</code> 类为按钮对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractButtonBaseSkin extends AbstractSkin
	{
		/**
		 * 记录组件内部用于显示按钮实体的背景容器对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * <code>AbstractButtonBaseSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractButtonBaseSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractButtonBaseSkin);
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			_background = (_owner as AbstractButtonBase).hammerc_internal::background;
		}
		
		/**
		 * 当组件的状态改变后会调用该方法.
		 * @param state 新设置的组件状态.
		 */
		public function onStateChanged(state:int):void
		{
		}
	}
}
