/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager.invalidateClasses
{
	/**
	 * <code>IInvalidating</code> 接口定义了延迟渲染布局对象应有的属性及方法.
	 * @author wizardc
	 */
	public interface IInvalidating
	{
		/**
		 * 获取本对象在显示列表中嵌套的层深度.
		 */
		function get nestLevel():int;
		
		/**
		 * 计算本对象在显示列表中嵌套的层深度.
		 */
		function calculateNestLevel():void;
		
		/**
		 * 指示本对象布局失效.
		 */
		function invalidateLayout():void;
		
		/**
		 * 下一帧渲染之前如果本对象的布局被标记为失效, 则会调用一次本方法更新布局.
		 */
		function validateLayout():void;
		
		/**
		 * 立即强制启动布局, 可立即获取组件布局后的有用信息.
		 * <p>正常流程下, 布局方法会在每帧重绘前被调用一次. 该方法在如向容器中添加了多个组件后需要滚动到最下方等情况下很实用.</p>
		 */
		function validateLayoutNow():void;
		
		/**
		 * 指示本对象的显示失效.
		 */
		function invalidateShow():void;
		
		/**
		 * 下一帧渲染之前如果本对象的显示被标记为失效, 则会调用一次本方法更新显示.
		 */
		function validateShow():void;
		
		/**
		 * 立即强制启动渲染, 可立即获取组件渲染后的有用信息.
		 * <p>正常流程下, 渲染方法会在每帧重绘前被调用一次. 该方法在需要立即执行渲染情况下使用.</p>
		 */
		function validateShowNow():void;
	}
}
