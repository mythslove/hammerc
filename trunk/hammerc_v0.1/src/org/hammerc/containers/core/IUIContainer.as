/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.containers.core
{
	import org.hammerc.controls.core.IUIComponent;
	
	/**
	 * <code>IUIContainer</code> 接口定义了容器的通用方法及属性.
	 * @author wizardc
	 */
	public interface IUIContainer extends IUIComponent
	{
		/**
		 * 获取容器内部组件的数量.
		 */
		function get numElements():int;
		
		/**
		 * 添加一个组件到容器中.
		 * @param element 要添加的组件.
		 * @return 添加的组件.
		 */
		function addElement(element:IUIComponent):IUIComponent;
		
		/**
		 * 添加一个组件到容器中指定的索引处.
		 * @param element 要添加的组件.
		 * @param index 添加的组件指定的索引.
		 * @return 添加的组件.
		 */
		function addElementAt(element:IUIComponent, index:int):IUIComponent;
		
		/**
		 * 判断指定的组件是否已经被本容器包含.
		 * @param element 要判断的组件.
		 * @return 组件是否已经被本容器包含.
		 */
		function containsElement(element:IUIComponent):Boolean;
		
		/**
		 * 获取指定索引处的组件.
		 * @param index 指定的索引.
		 * @return 指定索引处的组件.
		 */
		function getElementAt(index:int):IUIComponent;
		
		/**
		 * 获取指定名称的组件.
		 * @param name 指定的名称.
		 * @return 指定名称的组件.
		 */
		function getElementByName(name:String):IUIComponent;
		
		/**
		 * 获取指定组件的索引.
		 * @param element 要获取索引的组件.
		 * @return 指定组件的索引.
		 */
		function getElementIndex(element:IUIComponent):int;
		
		/**
		 * 移除指定的组件.
		 * @param element 要移除的组件.
		 * @return 移除的组件.
		 */
		function removeElement(element:IUIComponent):IUIComponent;
		
		/**
		 * 移除指定索引处的组件.
		 * @param index 要移除的索引.
		 * @return 移除的组件.
		 */
		function removeElementAt(index:int):IUIComponent;
		
		/**
		 * 移除多个组件.
		 * @param beginIndex 开始的索引.
		 * @param endIndex 结束的索引.
		 */
		function removeElements(beginIndex:int = 0, endIndex:int = 0x7fffffff):void;
		
		/**
		 * 设置指定组件的索引.
		 * @param element 要设置的组件.
		 * @param index 要设置的索引.
		 */
		function setElementIndex(element:IUIComponent, index:int):void;
		
		/**
		 * 交换两个组件的深度索引.
		 * @param element1 要交换的第一个组件.
		 * @param element2 要交换的第二个组件.
		 */
		function swapElements(element1:IUIComponent, element2:IUIComponent):void;
		
		/**
		 * 交换两个深度索引上的组件.
		 * @param index1 要交换的第一个深度索引.
		 * @param index2 要交换的第二个深度索引.
		 */
		function swapElementsAt(index1:int, index2:int):void;
	}
}
