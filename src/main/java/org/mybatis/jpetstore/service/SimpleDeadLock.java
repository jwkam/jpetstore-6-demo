/**
 *    Copyright 2010-2020 the original author or authors.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */
package org.mybatis.jpetstore.service;

import java.util.*;

public class SimpleDeadLock extends Thread {
  public static Object l1 = new Object();
  public static Object l2 = new Object();
  private int index;

  public static void main(String[] a) {
    Thread t1 = new Thread1();
    Thread t2 = new Thread2();
    t1.start();
    t2.start();
  }

  private static class Thread1 extends Thread {
    public void run() {
      synchronized (l1) {
        System.out.println("Thread 1: Holding lock 1...");
        try {
          Thread.sleep(10);
        } catch (InterruptedException e) {
        }
        System.out.println("Thread 1: Waiting for lock 2...");
        synchronized (l2) {
          System.out.println("Thread 2: Holding lock 1 & 2...");
        }
      }
    }
  }

  private static class Thread2 extends Thread {
    public void run() {
      synchronized (l2) {
        System.out.println("Thread 2: Holding lock 2...");
        try {
          Thread.sleep(10);
        } catch (InterruptedException e) {
        }
        System.out.println("Thread 2: Waiting for lock 1...");
        synchronized (l1) {
          System.out.println("Thread 2: Holding lock 2 & 1...");
        }
      }
    }
  }
}
