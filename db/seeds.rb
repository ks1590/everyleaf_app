status = ["未着手","着手中","完了"]
start_date = Date.parse("2021/02/01")
end_date = Date.parse("2021/02/28")

15.times do |n|
  get_date = Random.rand(start_date .. end_date)
  Task.create!(
    title: "タスクのサンプル#{n + 1}",
    detail: "このタスク#{n + 1}はダミーです。本課題は、株式会社万葉様より正式な許諾を経て、DIVE INTO CODEの課題として活用しています。文章は、DIVE INTO CODEの課題評価の形式と合わせるために一部改変されています。",
    deadline: get_date,
    priority: rand(0..2),
    status: status.sample
  )
end