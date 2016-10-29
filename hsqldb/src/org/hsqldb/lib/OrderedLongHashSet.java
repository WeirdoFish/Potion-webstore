/* Copyright (c) 2001-2014, The HSQL Development Group
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * Neither the name of the HSQL Development Group nor the names of its
 * contributors may be used to endorse or promote products derived from this
 * software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL HSQL DEVELOPMENT GROUP, HSQLDB.ORG,
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


package org.hsqldb.lib;

import org.hsqldb.map.BaseHashMap;

/**
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.2.7
 * @since 1.9.0
 */
public class OrderedLongHashSet extends BaseHashMap {

    public OrderedLongHashSet() {
        this(8);
    }

    public OrderedLongHashSet(int initialCapacity)
    throws IllegalArgumentException {

        super(initialCapacity, BaseHashMap.longKeyOrValue,
              BaseHashMap.noKeyOrValue, false);

        isList = true;
    }

    public boolean contains(long key) {
        return super.containsKey(key);
    }

    public boolean add(long key) {

        int oldSize = size();

        super.addOrRemove(key, 0, null, null, false);

        return oldSize != size();
    }

    public boolean remove(long key) {

        int oldSize = size();

        super.addOrRemove(key, 0, null, null, true);

        boolean result = oldSize != size();

        if (result) {
            long[] array = toArray();

            super.clear();

            for (int i = 0; i < array.length; i++) {
                add(array[i]);
            }
        }

        return result;
    }

    public long get(int index) {

        checkRange(index);

        return longKeyTable[index];
    }

    public int getIndex(long value) {
        return getLookup(value);
    }

    public int getStartMatchCount(long[] array) {

        int i = 0;

        for (; i < array.length; i++) {
            if (!super.containsKey(array[i])) {
                break;
            }
        }

        return i;
    }

    public int getOrderedStartMatchCount(long[] array) {

        int i = 0;

        for (; i < array.length; i++) {
            if (i >= size() || get(i) != array[i]) {
                break;
            }
        }

        return i;
    }

    public boolean addAll(Collection col) {

        int      oldSize = size();
        Iterator it      = col.iterator();

        while (it.hasNext()) {
            add(it.nextLong());
        }

        return oldSize != size();
    }

    public long[] toArray() {

        int   lookup = -1;
        long[] array  = new long[size()];

        for (int i = 0; i < array.length; i++) {
            lookup = super.nextLookup(lookup);

            long value = intKeyTable[lookup];

            array[i] = value;
        }

        return array;
    }

    private void checkRange(int i) {

        if (i < 0 || i >= size()) {
            throw new IndexOutOfBoundsException();
        }
    }
}
