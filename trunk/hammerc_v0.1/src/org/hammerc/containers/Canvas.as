/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.containers
{
	import org.hammerc.containers.core.AbstractUIContainer;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.containers.AbstractCanvasSkin;
	
	/**
	 * <code>Canvas</code> 类定义了不具备滚动条的容器, 需要带有滚动条的容器请使用 <code>Panel</code> 类.
	 * @see org.hammerc.containers.Panel
	 * @author wizardc
	 */
	public class Canvas extends AbstractUIContainer
	{
		/**
		 * 创建一个 <code>Canvas</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function Canvas(skinClass:Class = null)
		{
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractCanvasSkin;
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
