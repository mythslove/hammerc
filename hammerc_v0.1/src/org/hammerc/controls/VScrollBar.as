/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls
{
	import org.hammerc.controls.core.OrientationType;
	import org.hammerc.controls.scrollClasses.AbstractScrollBar;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.controls.AbstractVScrollBarSkin;
	
	/**
	 * <code>VScrollBar</code> 类定义了垂直滚动条.
	 * @author wizardc
	 */
	public class VScrollBar extends AbstractScrollBar
	{
		/**
		 * 创建一个 <code>VScrollBar</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function VScrollBar(skinClass:Class = null)
		{
			super(OrientationType.VERTICAL, skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractVScrollBarSkin;
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
