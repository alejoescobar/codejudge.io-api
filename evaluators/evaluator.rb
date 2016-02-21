require 'net/http'
require 'pp'
require 'json'
require 'timeout'
require 'open3'

get_submit_url = URI.parse(ENV['GET_SUBMIT_URL'] || 'http://api.codejudgeio.dev/worker/challenges/1/submits/1')
post_code_result_url = URI(ENV['POST_CODE_RESULT_URL'] || 'http://api.codejudgeio.dev/worker/challenges/1/submits/1/code_results')
auth_token = ENV['AUTH_TOKEN'] || '3kzbH2KUcPCddAqzM-7X'


http = Net::HTTP.new(get_submit_url.host, get_submit_url.port)
req = Net::HTTP::Get.new(get_submit_url.request_uri)
req['Authorization'] = auth_token
res = http.request(req)
submit = JSON.parse(res.body)

language = submit["language"]

solution_file_name = "solution.#{language}"

File.open(solution_file_name, 'w') { |file| file.write(submit["code"]) }

submit["test_cases"].each_with_index do |test_case,i|
  case submit['language']
  when 'rb'
    command = "ruby #{solution_file_name}"

    stdout,stderr,status = Open3.capture3(command, stdin_data: test_case["input"])
    if status.success?

      req = Net::HTTP::Post.new(post_code_result_url)
      req['Authorization'] = auth_token
      req.body = JSON.generate({
        test_case_id: test_case["id"],
        actual_output: stdout,
        evaluator_status: :ok,
        error: stderr
      })
      req.content_type = 'application/json'


      res = Net::HTTP.start(post_code_result_url.hostname, post_code_result_url.port) do |http|
        http.request(req)
      end

    else

      req = Net::HTTP::Post.new(post_code_result_url)
      req['Authorization'] = auth_token
      req.body = JSON.generate({
        test_case_id: test_case["id"],
        actual_output: stdout,
        evaluator_status: :error,
        error: stderr
      })
      req.content_type = 'application/json'


      res = Net::HTTP.start(post_code_result_url.hostname, post_code_result_url.port) do |http|
        http.request(req)
      end

    end
  when 'js'
    command = "node #{solution_file_name}"

    stdout,stderr,status = Open3.capture3(command, stdin_data: test_case["input"])
    if status.success?

      req = Net::HTTP::Post.new(post_code_result_url)
      req.body = JSON.generate({
        test_case_id: test_case["id"],
        actual_output: stdout,
        evaluator_status: :ok,
        error: stderr
      })
      req.content_type = 'application/json'


      res = Net::HTTP.start(post_code_result_url.hostname, post_code_result_url.port) do |http|
        http.request(req)
      end

    else

      req = Net::HTTP::Post.new(post_code_result_url)
      req.body = JSON.generate({
        test_case_id: test_case["id"],
        actual_output: stdout,
        evaluator_status: :error,
        error: stderr
      })
      req.content_type = 'application/json'


      res = Net::HTTP.start(post_code_result_url.hostname, post_code_result_url.port) do |http|
        http.request(req)
      end

    end
  end
end
