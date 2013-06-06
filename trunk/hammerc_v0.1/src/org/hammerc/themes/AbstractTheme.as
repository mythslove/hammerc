/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes
{
	import flash.utils.getQualifiedClassName;
	
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.skin.ISkin;
	
	/**
	 * <code>AbstractTheme</code> 类为主题类的抽象类, 实现主题类的核心方法.
	 * @author wizardc
	 */
	public class AbstractTheme implements ITheme
	{
		/**
		 * 记录所有组件的默认皮肤.
		 */
		protected var _defaultSkinMap:Object;
		
		/**
		 * <code>AbstractTheme</code> 类为抽象类, 不能被实例化.
		 */
		public function AbstractTheme()
		{
			AbstractEnforcer.enforceConstructor(this, AbstractTheme);
			_defaultSkinMap = new Object();
			this.init();
		}
		
		/**
		 * 初始化方法, 请在本方法类配置所有组件的默认皮肤.
		 */
		protected function init():void
		{
			AbstractEnforcer.enforceMethod();
		}
		
		/**
		 * 映射组件和其默认的皮肤类.
		 * @param componentClass 需要设置默认皮肤的组件类.
		 * @param defaultSkinClass 该组件使用的默认皮肤类.
		 */
		protected function mapDefaultSkin(componentClass:Class, defaultSkinClass:Class):void
		{
			var className:String = getQualifiedClassName(componentClass);
			_defaultSkinMap[className] = defaultSkinClass;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getDefaultSkin(owner:IUIComponent):ISkin
		{
			var className:String = getQualifiedClassName(owner);
			var skinClass:Class = _defaultSkinMap[className];
			if(skinClass == null)
			{
				throw new Error("组件\"" + className + "\"没有指定默认的皮肤！");
			}
			return new skinClass(owner);
		}
	}
}
