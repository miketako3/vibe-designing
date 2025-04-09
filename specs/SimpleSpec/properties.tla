\* 安全性プロパティ: 2つのプロセスが同時にクリティカルセクションに入らない
MutualExclusion == ~(\E i, j \in {1, 2}: i # j /\ pc[i] = "cs" /\ pc[j] = "cs")

\* 活性プロパティ: プロセスがクリティカルセクションに入りたいとき、いつかは入れる
Liveness == \A self \in {1, 2}: (pc[self] = "wait" ~> pc[self] = "cs")
