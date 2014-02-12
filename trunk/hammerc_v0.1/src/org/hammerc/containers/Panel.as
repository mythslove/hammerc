/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.containers
{
	import org.hammerc.containers.scrollerClasses.AbstractScroller;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.containers.AbstractPanelSkin;
	
	/**
	 * <code>Panel</code> 类定义了带有滚动条的容器, 需要不具备滚动条的容器请使用 <code>Canvas</code> 类.
	 * @see org.hammerc.containers.Canvas
	 * @author wizardc
	 */
	public class Panel extends AbstractScroller
	{
		/**
		 * 创建一个 <code>Panel</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function Panel(skinClass:Class = null)
		{
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractPanelSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createDefaultSkin():ISkin
		{
			return SkinManager.getInstance().defaultTheme.getDefaultSkin(this);
		}
	}
}
