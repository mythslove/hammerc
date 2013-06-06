/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager
{
	import org.hammerc.themes.ITheme;
	
	/**
	 * <code>SkinManager</code> 类管理组件使用的主题和皮肤.
	 * @author wizardc
	 */
	public class SkinManager
	{
		private static var _instance:SkinManager;
		
		/**
		 * 获取本类的唯一实例.
		 * @return 本类的唯一实例.
		 */
		public static function getInstance():SkinManager
		{
			if(_instance == null)
			{
				_instance = new SkinManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		private var _defaultTheme:ITheme;
		
		/**
		 * 本类为单例类不能实例化.
		 * @param singletonEnforcer 单例类实现对象.
		 */
		public function SkinManager(singletonEnforcer:SingletonEnforcer)
		{
			if(singletonEnforcer == null)
			{
				throw new Error("单例类不能进行实例化！");
			}
		}
		
		/**
		 * 注册使用的默认主题类.
		 * @param themeClass 要被注册的默认主题对象.
		 * @throws Error 主题对象为空或非 <code>ITheme</code> 子类时抛出该异常.
		 */
		public function registerDefaultTheme(themeClass:Class):void
		{
			_defaultTheme = new themeClass() as ITheme;
			if(_defaultTheme == null)
			{
				throw new Error("参数\"themeClass\"必须应用\"ITheme\"接口！");
			}
		}
		
		/**
		 * 获取默认的皮肤主题对象.
		 */
		public function get defaultTheme():ITheme
		{
			return _defaultTheme;
		}
	}
}

class SingletonEnforcer{}
