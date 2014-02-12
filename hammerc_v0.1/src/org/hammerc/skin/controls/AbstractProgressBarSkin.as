/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls
{
	import flash.display.Sprite;
	
	import org.hammerc.controls.ProgressBar;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.AbstractSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractProgressBarSkin</code> 类为滚动条的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractProgressBarSkin extends AbstractSkin
	{
		/**
		 * 记录组件内部用于显示背景的容器对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * 记录组件内部用于显示填充滚动条的容器对象.
		 */
		protected var _fillBar:Sprite;
		
		/**
		 * <code>AbstractProgressBarSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractProgressBarSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractProgressBarSkin);
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			_background = (_owner as ProgressBar).hammerc_internal::background;
			_fillBar = (_owner as ProgressBar).hammerc_internal::fillBar;
		}
		
		/**
		 * 获取该皮肤对象对应的组件.
		 * @return 该皮肤对象对应的组件.
		 */
		protected function getOwner():ProgressBar
		{
			return _owner as ProgressBar;
		}
		
		/**
		 * 当需要立即更新滚动条的填充条时会调用该方法.
		 */
		public function fillBarChange():void
		{
		}
		
		/**
		 * 当滚动条的值改变时会调用该方法.
		 * <p>与 <code>fillBarChange</code> 方法不同, 这里可以为填充条添加缓动效果.</p>
		 * @param value 新设置的滚动条的值.
		 */
		public function onValueChanged(value:Number):void
		{
		}
	}
}
