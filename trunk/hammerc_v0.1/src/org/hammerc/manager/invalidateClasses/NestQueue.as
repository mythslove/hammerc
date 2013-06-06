/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager.invalidateClasses
{
	/**
	 * <code>NestQueue</code> 类实现了根据显示对象嵌套的层深进行排序的功能, 使用二叉堆进行优化.
	 * @author wizardc
	 */
	public class NestQueue
	{
		/**
		 * 记录所有延迟渲染对象的列表.
		 */
		protected var _list:Vector.<IInvalidating>;
		
		/**
		 * 创建一个 <code>NestQueue</code> 对象.
		 */
		public function NestQueue()
		{
			_list = new Vector.<IInvalidating>();
		}
		
		/**
		 * 添加一个需要排序的延迟渲染对象.
		 * @param invalidating 要添加的延迟渲染对象.
		 */
		public function append(invalidating:IInvalidating):void
		{
			if(_list.indexOf(invalidating) != -1)
			{
				return;
			}
			var index:int = _list.push(invalidating);
			var temp:IInvalidating;
			while(index != 1 && _list[int(index / 2) - 1].nestLevel > invalidating.nestLevel)
			{
				temp = _list[index - 1];
				_list[index - 1] = _list[int(index / 2) - 1];
				_list[int(index / 2) - 1] = temp;
				index /= 2;
			}
		}
		
		/**
		 * 获取并移除嵌套的层深最小的延迟渲染对象.
		 * @return 嵌套的层深最小的延迟渲染对象.
		 */
		public function removeSmallest():IInvalidating
		{
			var invalidating:IInvalidating = _list.shift();
			if(_list.length > 1)
			{
				_list.unshift(_list.pop());
				var index:int = 1, subIndex1:int, subIndex2:int, len:int = _list.length, minIndex:int;
				var nowInvalidating:IInvalidating, subInvalidating1:IInvalidating, subInvalidating2:IInvalidating, temp:IInvalidating, minInvalidating:IInvalidating;
				while(true)
				{
					subIndex1 = index * 2;
					subIndex2 = index * 2 + 1;
					if(subIndex1 > len)
					{
						break;
					}
					nowInvalidating = _list[index - 1];
					subInvalidating1 = _list[subIndex1 - 1];
					subInvalidating2 = (subIndex2 > len) ? null : _list[subIndex2 - 1];
					if(subInvalidating2 != null)
					{
						minIndex = (subInvalidating1.nestLevel < subInvalidating2.nestLevel) ? subIndex1 : subIndex2;
						minInvalidating = _list[minIndex - 1];
						if(nowInvalidating.nestLevel > minInvalidating.nestLevel)
						{
							temp = _list[minIndex - 1];
							_list[minIndex - 1] = _list[index - 1];
							_list[index - 1] = temp;
							index = minIndex;
						}
						else
						{
							break;
						}
					}
					else
					{
						if(nowInvalidating.nestLevel > subInvalidating1.nestLevel)
						{
							temp = _list[subIndex1 - 1];
							_list[subIndex1 - 1] = _list[index - 1];
							_list[index - 1] = temp;
							index = subIndex1;
						}
						else
						{
							break;
						}
					}
				}
			}
			return invalidating;
		}
		
		/**
		 * 判断队列是否已经空了.
		 * @return 队列是否已空.
		 */
		public function isEmpty():Boolean
		{
			return _list.length == 0;
		}
		
		/**
		 * 清除所有的数据.
		 */
		public function clear():void
		{
			_list.length = 0;
		}
	}
}
