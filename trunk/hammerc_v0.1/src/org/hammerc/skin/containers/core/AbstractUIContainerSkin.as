/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.containers.core
{
	import flash.display.Sprite;
	
	import org.hammerc.containers.core.AbstractUIContainer;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.AbstractSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractUIContainerSkin</code> 类为容器对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractUIContainerSkin extends AbstractSkin
	{
		/**
		 * 记录容器内部的背景容器对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * 记录实际添加子对象的容器对象.
		 */
		protected var _content:Sprite;
		
		/**
		 * <code>AbstractUIContainerSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractUIContainerSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractUIContainerSkin);
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			_background = (_owner as AbstractUIContainer).hammerc_internal::background;
			_content = (_owner as AbstractUIContainer).hammerc_internal::content;
		}
	}
}
