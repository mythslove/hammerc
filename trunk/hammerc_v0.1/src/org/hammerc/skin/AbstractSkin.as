/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin
{
	import org.hammerc.controls.core.AbstractUIComponent;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractSkin</code> 类为所有皮肤的基类, 定义了皮肤的基本属性及方法.
	 * @author wizardc
	 */
	public class AbstractSkin implements ISkin
	{
		/**
		 * 拥有该皮肤对象的组件.
		 */
		protected var _owner:IUIComponent;
		
		/**
		 * <code>AbstractSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractSkin);
			_owner = owner;
			this.init();
		}
		
		/**
		 * 初始化皮肤对象时会调用该方法.
		 */
		protected function init():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function load():void
		{
			this.addChildren();
			this.configuration();
			if((_owner as AbstractUIComponent).hammerc_internal::initialized)
			{
				this.changeChildrenSkinClass();
			}
			this.invalidateShow();
		}
		
		/**
		 * 添加皮肤对象特有的子显示对象到组件中的方法.
		 */
		protected function addChildren():void
		{
		}
		
		/**
		 * 配置皮肤对象默认属性的方法.
		 */
		protected function configuration():void
		{
		}
		
		/**
		 * 改变组件内部子组件的皮肤类.
		 */
		protected function changeChildrenSkinClass():void
		{
		}
		
		/**
		 * 当组件的尺寸改变后会调用该方法.
		 * @param width 新设置的组件宽度.
		 * @param height 新设置的组件高度.
		 */
		public function onSizeChanged(width:Number, height:Number):void
		{
		}
		
		/**
		 * 当组件是否可以接受用户交互的值改变后会调用该方法.
		 * @param enabled 新设置的组件是否可以接受用户交互的值.
		 */
		public function onEnabledChanged(enabled:Boolean):void
		{
		}
		
		/**
		 * 设定一个风格.
		 * @param name 要设定的风格名称.
		 * @param value 要设定的风格的值.
		 */
		public function setStyle(name:String, value:*):void
		{
		}
		
		/**
		 * 获取指定的一个风格.
		 * @param name 要获取的风格名称.
		 * @return 指定的风格.
		 */
		public function getStyle(name:String):*
		{
		}
		
		/**
		 * 指示本对象的显示失效.
		 */
		protected function invalidateShow():void
		{
			(_owner as AbstractUIComponent).invalidateShow();
		}
		
		/**
		 * @inheritDoc
		 */
		public function drawSkin():void
		{
			AbstractEnforcer.enforceMethod();
		}
		
		/**
		 * @inheritDoc
		 */
		public function unload():void
		{
			this.removeChildren();
		}
		
		/**
		 * 从组件中移除皮肤对象特有的子显示对象的方法.
		 */
		protected function removeChildren():void
		{
		}
	}
}
