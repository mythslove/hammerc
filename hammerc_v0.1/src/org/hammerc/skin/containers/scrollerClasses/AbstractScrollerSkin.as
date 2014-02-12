/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.containers.scrollerClasses
{
	import org.hammerc.containers.scrollerClasses.AbstractScroller;
	import org.hammerc.controls.HScrollBar;
	import org.hammerc.controls.VScrollBar;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.containers.core.AbstractUIContainerSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractScrollerSkin</code> 类为面板对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractScrollerSkin extends AbstractUIContainerSkin
	{
		/**
		 * 记录水平滚动条对象.
		 */
		protected var _horizontalScrollBar:HScrollBar;
		
		/**
		 * 记录水平滚动条使用的皮肤类对象.
		 */
		protected var _horizontalScrollBarSkinClass:Class;
		
		/**
		 * 记录垂直滚动条对象.
		 */
		protected var _verticalScrollBar:VScrollBar;
		
		/**
		 * 记录垂直滚动条使用的皮肤类对象.
		 */
		protected var _verticalScrollBarSkinClass:Class;
		
		/**
		 * <code>AbstractScrollerSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractScrollerSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractScrollerSkin);
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			super.configuration();
			_horizontalScrollBar = (_owner as AbstractScroller).hammerc_internal::horizontalScrollBar;
			_verticalScrollBar = (_owner as AbstractScroller).hammerc_internal::verticalScrollBar;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function changeChildrenSkinClass():void
		{
			_horizontalScrollBar.skinClass = _horizontalScrollBarSkinClass;
			_verticalScrollBar.skinClass = _verticalScrollBarSkinClass;
		}
		
		/**
		 * 创建组件内部使用的水平滚动条对象.
		 * @return 组件内部使用的水平滚动条对象.
		 */
		public function createHorizontalScrollBar():HScrollBar
		{
			return null;
		}
		
		/**
		 * 创建组件内部使用的垂直滚动条对象.
		 * @return 组件内部使用的垂直滚动条对象.
		 */
		public function createVerticalScrollBar():VScrollBar
		{
			return null;
		}
	}
}
