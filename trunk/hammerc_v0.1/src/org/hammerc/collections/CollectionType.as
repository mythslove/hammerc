/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.collections
{
	/**
	 * <code>CollectionType</code> 类枚举了列表项目改变的所有类型.
	 * @author wizardc
	 */
	public class CollectionType
	{
		/**
		 * 添加项目.
		 */
		public static const ADD:int = 0;
		
		/**
		 * 替换项目.
		 */
		public static const REPLACE:int = 1;
		
		/**
		 * 移除项目.
		 */
		public static const REMOVE:int = 2;
		
		/**
		 * 移除所有项目.
		 */
		public static const REMOVE_ALL:int = 3;
		
		/**
		 * 排序项目.
		 */
		public static const SORT:int = 4;
	}
}
